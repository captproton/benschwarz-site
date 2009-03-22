Stream.fix {{
  :title => DataMapper::Sweatshop.unique { /\w+/.gen },
  :description => /\w+/.gen
}}

Source.fix {{
  :href => Faker::Internet.domain_name,
  :external_id => /\d{11}/.gen
}}