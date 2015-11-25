require 'spec_helper'

describe Potpourri::ActiveRecord::IdentifierField do
  let(:field) { described_class.new :name }

  describe '#importable?' do
    subject { field.importable? }
    it { is_expected.to be_falsy }
  end

  describe '#identifier?' do
    subject { field.identifier? }
    it { is_expected.to be_truthy }
  end
end
