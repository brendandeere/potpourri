ActiveRecord::Schema.define do
  self.verbose = false

  create_table :test_class, force: true do |t|
    t.string :name
    t.string :quantity
  end
end
