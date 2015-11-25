require 'spec_helper'

describe Potpourri::ActiveRecordExtension do
  let(:report) { TestReport.new path }
  let(:path) { 'test_path.csv' }

  fields = [
      Potpourri::ActiveRecord::IdentifierField.new(:id),
      Potpourri::Field.new(:name),
      Potpourri::Field.new(:quantity)
  ]

  class TestReport < Potpourri::Report
    resource_class Potpourri::ActiveRecord::TestClass
  end

  TestReport.include described_class
  TestReport.fields fields

  shared_context 'can_create', create: true do
    before { TestReport.create_new_records }
  end

  shared_context 'can_create', create: false do
    before { TestReport.create_new_records false }
  end

  shared_context 'can_update', update: true do
    before { TestReport.update_existing_records }
  end

  shared_context 'can_update', update: false do
    before { TestReport.update_existing_records false }
  end

  shared_context 'without_identifier', identifier: false do
    before { TestReport.fields [] }
    after { TestReport.fields fields }
  end

  describe '.create_new_records' do
    subject { TestReport.create_new_records *args }

    context 'with an argument' do
      let(:args) { [false] }

      it { is_expected.to eq args.first }

      it 'sets a class instance variable' do
        subject
        expect(TestReport.instance_variable_get '@can_create_new_records').to eq args.first
      end
    end

    context 'without an argument' do
      let(:args) { [] }

      it { is_expected.to eq true }

      it 'sets a class instance variable' do
        subject
        expect(TestReport.instance_variable_get '@can_create_new_records').to eq true
      end
    end
  end

  describe '.update_existing_records' do
    subject { TestReport.update_existing_records *args }

    context 'with an argument' do
      let(:args) { [false] }

      it { is_expected.to eq args.first }

      it 'sets a class instance variable' do
        subject
        expect(TestReport.instance_variable_get '@can_update_existing_records').to eq args.first
      end
    end

    context 'without an argument' do
      let(:args) { [] }

      it { is_expected.to eq true }

      it 'sets a class instance variable' do
        subject
        expect(TestReport.instance_variable_get '@can_update_existing_records').to eq true
      end
    end
  end

  describe '#can_update_existing_records?' do
    subject { report.can_update_existing_records? }

    context 'flag is set', update: true do
      it { is_expected.to be_truthy }
    end

    context 'flag is not set', update: false do
      it { is_expected.to be_falsy }
    end
  end

  describe '#can_create_new_records?' do
    subject { report.can_create_new_records? }

    context 'flag is set', create: true do
      it { is_expected.to be_truthy }
    end

    context 'flag is not set', create: false do
      it { is_expected.to be_falsy }
    end
  end

  describe '#identifier_field' do
    subject { report.identifier_field }

    context 'there is an identifier field' do
      it { is_expected.to eq fields.first }
    end

    context 'there is not an identifier field', identifier: false do
      it { is_expected.to be_nil }
    end
  end

  describe '#import' do
    subject { report.import.first }
    let(:path) { 'spec/fixtures/active_record_test_class.csv' }

    context 'without an identifier field', identifier: false do
      it 'raises an error' do
        expect { subject }.to raise_error Potpourri::ActiveRecordExtension::MissingIdentifierField
      end
    end

    context 'can only create records', create: true, update: false do
      it 'is a TestClass' do
        expect(subject.class).to eq Potpourri::ActiveRecord::TestClass
      end
    end

    context 'can only update records', create: false, update: true do
      let(:test_class) { Potpourri::ActiveRecord::TestClass.create id: 99 }

      context 'the record exists' do
        before { test_class }
        it { is_expected.to eq test_class }
      end

      context 'the record doesnt exist' do
        it 'raises an error' do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    context 'can create and update records', create: true, update: true do
      let(:name) { 'supertest' }
      let(:test_class) { Potpourri::ActiveRecord::TestClass.create id: 99 }

      context 'the record exists' do
        before { test_class }
        it { is_expected.to have_attributes(name: name) }
      end

      context 'the record doesnt exist' do
        it 'creates a new record' do
          expect { subject }.to change { Potpourri::ActiveRecord::TestClass.count }.by 1
        end

        it { is_expected.to have_attributes(name: name) }
      end
    end
  end
end
