class CreateTicketTags < ActiveRecord::Migration[7.0]
  def change
    create_table :ticket_tags do |t|
      t.integer :tag_id, :unsigned => true
      t.integer :ticket_id, :unsigned => true

      t.timestamps
    end
  end
end
