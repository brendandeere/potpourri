require 'spec_helper'

RSpec.describe Potpourri::ImportableField do
  let(:field) { described_class.new :name }

  describe '#exportable?' do
    subject { field.exportable? }
    it { is_expected.to be_falsy }
  end
end
