Stream.fix {{
  :title => DataMapper::Sweatshop.unique { /\w+/.gen },
  :description => /\w+/.gen,
  :href => Faker::Internet.domain_name
}}