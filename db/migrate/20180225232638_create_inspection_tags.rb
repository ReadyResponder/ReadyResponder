class CreateInspectionTags < ActiveRecord::Migration
  def change
    create_table :inspection_tags do |t|
      t.string :name, null: false, uniqueness: true
      t.timestamps
    end

    create_table :tagging, id: false do |t|
      t.belongs_to :inspection_tag, index: true
      t.references :taggable, polymorphic: true, index: true
    end

    add_reference :item_types, :taggable, polymorphic: true, index: true
    add_reference :item_categories, :taggable, polymorphic: true, index: true
    add_reference :inspection_questions, :taggable, polymorphic: true, index: true
  end
end
