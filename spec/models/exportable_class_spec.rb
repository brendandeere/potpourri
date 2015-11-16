require 'spec_helper'

RSpec.describe Potpourri::ExportableField do
  let(:field) { described_class.new :name }

  describe '#importable?' do
    subject { field.importable? }
    it { is_expected.to be_falsy }
  end
end
