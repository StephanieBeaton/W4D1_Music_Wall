class Vote < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

  validate :vote_must_have_unique_track_user_combo

  def vote_must_have_unique_track_user_combo
    # binding.pry
    vote = Vote.where('track_id = ? AND user_id = ?', track_id, user_id)
    if vote != []
      errors[:track_id] << "Cannot vote for same song twice."
    end
  end
end
