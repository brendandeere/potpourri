require 'spec_helper'

RSpec.describe Potpourri::Field do
  let(:field) { described_class.new name, options }
  let(:name) { :test_field }
  let(:options) { Hash.new }

  describe 'initialization' do
    subject { field }

    let(:expected_attributes) do
      {
        name: :name,
        header: 'Name',
        export_method: :name,
        import_method: :name=
      }
    end

    context 'witha symbol name without options' do
      let(:name) { :name }
      it { is_expected.to have_attributes expected_attributes }
    end

    context 'with string name and without options' do
      let(:name) { 'name' }
      it { is_expected.to have_attributes expected_attributes }
    end

    context 'with an export_method option' do
      let(:name) { :name }
      let(:options) { Hash[:export_method, :super_method] }
      let(:attributes) { expected_attributes.merge options }

      it { is_expected.to have_attributes attributes }
    end

    context 'with an import_method option' do
      let(:name) { :name }
      let(:options) { Hash[:import_method, :import_name] }
      let(:attributes) { expected_attributes.merge options }

      it { is_expected.to have_attributes attributes }
    end

    context 'with a header option' do
      let(:name) { :name }
      let(:options) { Hash[:header, "SoMeNaMe"] }
      let(:attributes) { expected_attributes.merge options }

      it { is_expected.to have_attributes attributes }
    end
  end

  describe '#importable?' do
    subject { field.importable? }
    it { is_expected.to be_truthy }
  end

  describe '#exportable?' do
    subject { field.exportable? }
    it { is_expected.to be_truthy }
  end

  describe '#import' do
    subject { field.import resource, value }
    let(:options) { Hash[:import_method, :name=] }
    let(:value) { 42 }
    let(:resource) { double 'Object' }

    context 'the field is importable' do
      it 'calls the import_method on the resource' do
        expect(resource).to receive(:name=).with(value)
        subject
      end
    end

    context 'the field is not importable' do
      before { allow(field).to receive(:importable?).and_return false }

      it 'raises an unimportable field error' do
        expect { subject }.to raise_error Potpourri::Field::Unimportable
      end
    end
  end

  describe '#export' do
    subject { field.export resource}
    let(:options) { Hash[:export_method, :firefly] }
    let(:resource) { double 'Object' }

    context 'the field is exportable' do
      it 'calls the export_method on the resource' do
        expect(resource).to receive(:firefly).with no_args
        subject
      end
    end

    context 'the field is not exportable' do
      before { allow(field).to receive(:exportable?).and_return false }

      it 'raises an unimportable field error' do
        expect { subject }.to raise_error Potpourri::Field::Unexportable
      end
    end
  end
end
