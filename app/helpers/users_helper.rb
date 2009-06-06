module UsersHelper

  def win_lose_helper(current_user, user)
    if current_user
      "#{current_user.wins_against(user)}-#{current_user.losses_against(user)}"
    else
      "#{user.won_games.count}-#{user.lost_games.count}"
    end
  end

end
