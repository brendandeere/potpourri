# Potpourri
A simple DSL to structure CSV importer and exporter for all of your models.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'potpourri'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install potpourri

## Usage

The basic implementation will work for models which accept a hash as the only argument. Start by defining a report class which inherits from `Potpourri::Report`.

```ruby
class Starship
  attr_accessor :captain, :registration_number, :shield_frequency

  def initialize(captain: nil, registration_number: nil, shield_frequency: nil)
    captain, registation_number, shield_frequency = [captain, registation_number, shield_frequency]
  end
end

class StarshipReport < Potpourri::Report
  resource_class Starship

  fields [
    Potpourri::Field(:captain),
    Potpourri::ExportableField(:registration_number),
    Potpourri::ImportableField(:shield_frequency)
  ]
end
```

Thats it! Youll now be able to initialize a new Starship report which takes a path as its only argument:

```ruby
report = StarshipReport.new('starfleet/records/starships.csv')

report.export(starships)
# => a CSV object
# Captain,Registration Number
# Wharf, NX-74205

# Given a csv at the specified path
# Captain, Shield Frequency
# Sisko, 3.14159

report.import # => An array of Starship objects
```

### Customizing Fields

Fields can be customized in a number of ways. It is easy to decide what fields will be imported and which are
exported. Extra fields in an import will simply be ignored, so all generated exports are able to be imported.

- Potpourri::Field           => These fields will be both imported and exported
- Potpourri::ExportableField => These fields will only be exported
- Potpourri::ImportableField => These fields will only be imported

Fields will interpolate which methods are used to get and set values on a model. They will also use a
variation of the Rails `#titleize` method to generate a header for the csv.

`Potpourri::Field.new(:captain)` use `captain` as a getter and `captain=` as a setter.

These assumptions can be easily overriden by passing some options into the Field when the report is defined.

```ruby
  fields [
    Potpourri::Field(:registration_number),
    Potpourri::Field(:captain),
    Potpourri::ImportableField(:shield_frequency)
  ]
...

fields [
    Potpourri::Field(
      :captain,
      export_method: :command_officer,
      import_method: :fearless_leader=,
      header: 'Designation'
    )
]

...

```
The importable and exportable fields also respond to the same methods, however of course they will only be either importable or exportable.

### ActiveRecord Extension

Importing and exporting dynamic models is only so useful. Enter the ActiveRecord extension. It provides a
`Potpourri::ActiveRecord::Report` class. This class is a subclass of `Potpourri::Report` so it responds in
much the same way, with some bells and whistles.

```ruby
class StarshipReport < Potpourri::ActiveRecord::Report
  resource_class Starship

  fields [
    Potpourri::IdentifierField(:registration_number),
    Potpourri::Field(:captain),
    Potpourri::ImportableField(:shield_frequency)
  ]

  can_create_new_records
  can_update_existing_records
end
```

The big additions are:
- The identifierField
  - This field is required to import any record
  - it can be any model field so long as it is unique
  - it accepts all the same options as `Potpourri::Field`
  - Is not importable

- `can_create_new_records`
  - lets the report create records if no match for the identifier can be found
  - false by default
  - accepts an argument and can be dynamically changed

- `can_update_existing_fields`
  - lets the report update existing records
  - will not overwrite the identifier field
  - false by default
  - accepts an argument and can be dynamically changed

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/potpourri/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
