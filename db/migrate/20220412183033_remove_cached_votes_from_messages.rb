class RemoveCachedVotesFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :cached_votes_total
    remove_column :messages, :cached_votes_score
    remove_column :messages, :cached_votes_up
    remove_column :messages, :cached_votes_down
    remove_column :messages, :cached_weighted_score
    remove_column :messages, :cached_weighted_total
    remove_column :messages, :cached_weighted_average
  end
end
