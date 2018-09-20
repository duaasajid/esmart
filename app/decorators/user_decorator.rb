class UserDecorator < Draper::Decorator
  delegate_all

  def reputation_badge
    case reputation
    when 7.0..10.0
      h.tag.span 'Good Sport'.capitalize, class: 'badge badge-success'
    when 0.0...7.0
      h.tag.span 'Suspected Cheater'.capitalize, class: 'badge badge-warning'
    else
      h.tag.span 'Reputation Unknown'.capitalize, class: 'badge badge-secondary'
    end
  end

end
