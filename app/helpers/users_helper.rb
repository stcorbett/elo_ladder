module UsersHelper

  def win_lose_helper(current_user, user)
    if current_user
      "#{current_user.num_wins_against(user)}-#{current_user.num_losses_against(user)}"
    else
      "#{user.won_games.count}-#{user.lost_games.count}"
    end
  end
  
  def record_of(user, competitor)
    "#{user.num_wins_against(competitor)}-#{user.num_losses_against(competitor)}"
  end
  
  def last_game_between(user, competitor)
    user.last_game_against(competitor).created_at.strftime("%c")
  end

end
