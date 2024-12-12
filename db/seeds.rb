# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

clients = [
  {
    name: 'rock_walls_only',
    custom_fields_attributes: [
      { name: 'rock_wall_size',   display_name: 'Size of rock wall',   field_type: :number },
      { name: 'rock_wall_length', display_name: 'Length of rock wall', field_type: :number }
    ]
  }, {
    name: 'brick_walls_only',
    custom_fields_attributes: [
      { name: 'brick_color', display_name: 'Color of bricks to use',  field_type: :free   },
      { name: 'brick_count', display_name: 'Number of bricks to use', field_type: :number }
    ]
  }, {
    name: 'frame_walls_only',
    custom_fields_attributes: [
      { name: 'wall_stud_count', display_name: 'Numbr of studs required', field_type: :number },
      {
        name: 'wall_stud_size',
        display_name: 'Size of studs to use',
        field_type: :enum,
        custom_field_options_attributes: [
          { value: '2x4x8'  },
          { value: '2x4x10' },
          { value: '2x4x12' },
          { value: '2x6x8'  },
          { value: '2x6x10' },
          { value: '2x6x12' }
        ]
      }
    ]
  }, {
    name: 'brick_and_frame_walls',
    custom_fields_attributes: [
      { name: 'brick_color',     display_name: 'Color of bricks to use',  field_type: :free   },
      { name: 'brick_count',     display_name: 'Number of bricks to use', field_type: :number },
      { name: 'wall_stud_count', display_name: 'Numbr of studs required', field_type: :number },
      {
        name: 'wall_stud_size',
        display_name: 'Size of studs to use',
        field_type: :enum,
        custom_field_options_attributes: [
          { value: '2x4x8'  },
          { value: '2x4x10' },
          { value: '2x4x12' },
          { value: '2x6x8'  },
          { value: '2x6x10' },
          { value: '2x6x12' }
        ]
      }
    ]
  }, {
    name: 'rock_and_frame_walls',
    custom_fields_attributes: [
      { name: 'rock_wall_size',   display_name: 'Size of rock wall',       field_type: :number },
      { name: 'rock_wall_length', display_name: 'Length of rock wall',     field_type: :number },
      { name: 'wall_stud_count',  display_name: 'Numbr of studs required', field_type: :number },
      {
        name: 'wall_stud_size',
        display_name: 'Size of studs to use',
        field_type: :enum,
        custom_field_options_attributes: [
          { value: '2x4x8'  },
          { value: '2x4x10' },
          { value: '2x4x12' },
          { value: '2x6x8'  },
          { value: '2x6x10' },
          { value: '2x6x12' }
        ]
      }
    ]
  }
]

buildings = {
  rock_walls_only: [
    {
      street_1: '1100 S Congress Ave',
      city: 'Austin',
      state: 'TX',
      zipcode: '78704',
      custom_fields: { rock_wall_size: 20, rock_wall_length: 100 }
    }, {
      street_1: '123 Fake Address Way',
      city: 'Austin',
      state: 'TX',
      zipcode: '78704',
      custom_fields: { rock_wall_size: 10, rock_wall_length: 50 }
    }
  ],
  brick_walls_only: [
    {
      street_1: '110 Inner Campus Dr',
      city: 'Austin',
      state: 'TX',
      zipcode: '78712',
      custom_fields: { brick_color: 'red', brick_count: 1_000 }
    }, {
      street_1: '456 Fake Address Way',
      city: 'Austin',
      state: 'TX',
      zipcode: '78704',
      custom_fields: { brick_color: 'white', brick_count: 100 }
    }
  ],
  frame_walls_only: [
    {
      street_1: '801 Red River St',
      city: 'Austin',
      state: 'TX',
      zipcode: '78701',
      custom_fields: { wall_stud_size: '2x6x12', wall_stud_count: 500 }
    }, {
      street_1: '789 Fake Address Way',
      city: 'Austin',
      state: 'TX',
      zipcode: '78704',
      custom_fields: { wall_stud_size: '2x4x10', wall_stud_count: 200 }
    }
  ],
  brick_and_frame_walls: [
    {
      street_1: '11410 Century Oaks Ter',
      city: 'Austin',
      state: 'TX',
      zipcode: '78758',
      custom_fields: {
        brick_color: 'white',
        brick_count: 100,
        wall_stud_size: '2x6x12',
        wall_stud_count: 500
      }
    }, {
      street_1: '1234 The Best St',
      city: 'Austin',
      state: 'TX',
      zipcode: '78727',
      custom_fields: {
        brick_color: 'brown',
        brick_count: 100,
        wall_stud_size: '2x4x8',
        wall_stud_count: 500
      }
    }
  ],
  rock_and_frame_walls: [
    {
      street_1: '900 E 11th St',
      city: 'Austin',
      state: 'TX',
      zipcode: '78702',
      custom_fields: {
        rock_wall_size: 15.5,
        rock_wall_length: 150,
        wall_stud_size: '2x6x10',
        wall_stud_count: 200
      }
    }, {
      street_1: '5678 The Best St',
      city: 'Austin',
      state: 'TX',
      zipcode: '78727',
      custom_fields: {
        rock_wall_size: 20,
        rock_wall_length: 222.5,
        wall_stud_size: '2x4x10',
        wall_stud_count: 200
      }
    }
  ]
}

clients.each { Client.create!(_1) }
buildings.each do |name, attributes|
  Client.find_by!(name:).buildings.create!(attributes)
end
