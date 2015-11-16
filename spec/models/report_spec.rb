require 'spec_helper'

RSpec.describe Potpourri::Report do
  let(:report) { described_class.new path }
  let(:path) { 'somepath.csv' }

  before do
    TestClass = Struct.new(:a, :b)
    described_class.resource_class TestClass

    described_class.fields [
      Potpourri::Field.new(:a),
      Potpourri::Field.new(:b)
    ]
  end

  let(:models) do
    [
      TestClass.new(1, 2),
      TestClass.new(3, 4),
      TestClass.new(5, 6)
    ]
  end

  describe '#headers' do
    subject { report.headers }
    let(:field) { instance_double Potpourri::Field, header: 'Header' }

    before do
      described_class.fields 3.times.map { field }
    end

    it { is_expected.to eq ['Header', 'Header', 'Header'] }
  end

  describe '#import' do
    subject { report.import }

    context 'the file has the correct columns' do
      let(:path) { 'spec/fixtures/test.csv' }
      it { is_expected.to eq models }
    end

    context 'the file has extra columns' do
      let(:path) { 'spec/fixtures/extra_columns.csv' }
      it { is_expected.to eq models }
    end

    context 'the file is missing columns' do
      let(:path) { 'spec/fixtures/missing_columns.csv' }
      before { models.each { |m| m.a = nil } }

      it { is_expected.to eq models }
    end
  end

  describe '#export' do
    subject { report.export(models) }
    let(:path) { 'test.csv' }
    let(:fixture_data) { File.read 'spec/fixtures/test.csv' }

    after { File.delete 'test.csv' }

    it 'exports the correct data' do
      test_data = File.read subject.path
      expect(test_data).to eq fixture_data
    end
  end
end
