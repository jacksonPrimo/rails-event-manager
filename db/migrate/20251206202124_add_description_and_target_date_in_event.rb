# frozen_string_literal: true

# add description and target date fields in event
class AddDescriptionAndTargetDateInEvent < ActiveRecord::Migration[7.1]
  def up
    change_table(:events, bulk: true) do |t|
      t.string :description, null: false, default: ''
      t.datetime :target_date, null: false, default: -> { "CURRENT_TIMESTAMP + interval '1 day'" }
    end

    execute("UPDATE events SET description = '' WHERE description IS NULL")
    execute("UPDATE events SET target_date = created_at + interval '1 day' WHERE target_date IS NULL")

    add_check_constraint :events, 'char_length(description) <= 100', name: 'description_max_length'
  end

  def down
    remove_check_constraint :events, name: 'description_max_length'
    change_table(:events, bulk: true) do |t|
      t.remove :description
      t.remove :target_date
    end
  end
end
