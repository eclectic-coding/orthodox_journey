# spec/policies/application_policy_spec.rb
require 'rails_helper'

RSpec.describe ApplicationPolicy do
  let(:user) { double('user') }
  let(:record) { double('record') }
  let(:policy) { described_class.new(user, record) }

  describe '#index?' do
    it 'returns false' do
      expect(policy.index?).to be_falsey
    end
  end

  describe '#show?' do
    it 'returns false' do
      expect(policy.show?).to be_falsey
    end
  end

  describe '#create?' do
    it 'returns false' do
      expect(policy.create?).to be_falsey
    end
  end

  describe '#new?' do
    it 'returns false' do
      expect(policy.new?).to be_falsey
    end
  end

  describe '#update?' do
    it 'returns false' do
      expect(policy.update?).to be_falsey
    end
  end

  describe '#edit?' do
    it 'returns false' do
      expect(policy.edit?).to be_falsey
    end
  end

  describe '#destroy?' do
    it 'returns false' do
      expect(policy.destroy?).to be_falsey
    end
  end

  describe 'Scope' do
    let(:scope) { double('scope') }
    let(:policy_scope) { described_class::Scope.new(user, scope) }

    describe '#resolve' do
      it 'raises NoMethodError' do
        expect { policy_scope.resolve }.to raise_error(NoMethodError, /You must define #resolve in/)
      end
    end
  end
end# frozen_string_literal: true
