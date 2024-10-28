#!/usr/bin/env node

import * as esbuild from "esbuild"
import path from "path"
import chokidar from "chokidar"
import http from "http"
import { setTimeout } from "timers/promises"

const clients = []
const entryPoints = [
  "application.js"
]
const watchDirectories = [
  "./app/javascript",
  "./app/components",
  "./app/views",
  "./app/assets/builds", // Wait for cssbundling changes
]
const config = {
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  bundle: true,
  entryPoints: entryPoints,
  minify: process.env.RAILS_ENV === "production",
  outdir: path.join(process.cwd(), "app/assets/builds"),
  plugins: [],
  sourcemap: process.env.RAILS_ENV !== "production"
}

async function buildAndReload() {
  // Foreman & Overmind assign a separate PORT for each process
  const port = parseInt(process.env.PORT || 3200)
  console.log(`Esbuild is listening on port ${port}`)
  const context = await esbuild.context({
    ...config,
    banner: {
      js: `
        (() => {
          if (typeof EventSource !== 'undefined') {
            new EventSource("http://localhost:${port}").onmessage = () => location.reload()
          }
        })();
      `,
    }
  })

  // Reload uses an HTTP server as an even stream to reload the browser
  http
    .createServer((req, res) => {
      return clients.push(
        res.writeHead(200, {
          "Content-Type": "text/event-stream",
          "Cache-Control": "no-cache",
          "Access-Control-Allow-Origin": "*",
          Connection: "keep-alive",
        })
      )
    })
    .listen(port)

  await context.rebuild()
  console.log("[reload] initial build succeeded")

  let ready = false
  chokidar.watch(watchDirectories)
    .on("ready", () => {
      console.log("[reload] ready")
      ready = true
    })
    .on("all", async (event, path) => {
      if (ready === false)  return

      if (path.includes("javascript")) {
        try {
          await setTimeout(20)
          await context.rebuild()
          console.log("[reload] build succeeded")
        } catch (error) {
          console.error("[reload] build failed", error)
        }
      }
      clients.forEach((res) => res.write("data: update\n\n"))
      clients.length = 0
    })
}

if (process.argv.includes("--reload")) {
  buildAndReload()
} else if (process.argv.includes("--watch")) {
  let context = await esbuild.context({...config, logLevel: 'info'})
  context.watch()
} else {
  esbuild.build(config)
}
