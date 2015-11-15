require 'spec_helper'

RSpec.describe Potpourri::Titleize do
  let(:test_class) { TestClass.new }

  before do
    TestClass = Struct.new(:foo) do
      include Potpourri::Titleize
    end
  end

  describe '#titleize' do
    subject { test_class.titleize string }

    context 'a single word' do
      let(:string) { 'superman'}
      it { is_expected.to eq 'Superman' }
    end

    context 'words are separated by spaces' do
      let(:string) { 'this is a test string' }
      it { is_expected.to eq 'This Is A Test String' }
    end

    context 'words are separated by underscores' do
      let(:string) { 'this_is_a_test_string' }
      it { is_expected.to eq 'This Is A Test String' }
    end
  end
end
