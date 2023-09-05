class ChangeColumnTypeOnArticles < ActiveRecord::Migration[7.0]
  def change
    change_column :articles, :content, :jsonb
  end
end
