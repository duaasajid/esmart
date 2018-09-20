class MatchDecorator < Draper::Decorator
  delegate_all

  def player1_info
    h.capture do
      h.concat h.image_tag player1.avatar.variant(combine_options: { thumbnail: '50x50^', extent: '50x50', gravity: 'center' }), alt: player1.email, title: player1.email
      h.concat h.tag.span(score1.to_i, class: 'font-weight-bold ml-2 mr-2')
    end
  end

  def player2_info
    h.capture do
      h.concat h.tag.span(score2.to_i, class: 'font-weight-bold ml-2 mr-2')
      h.concat h.image_tag player2.avatar.variant(combine_options: { thumbnail: '50x50^', extent: '50x50', gravity: 'center' }), alt: player2.email, title: player2.email
    end
  end

  def start_time
    created_at.to_formatted_s(:long)
  end

  def status
    if in_progress?
      h.tag.span 'in progress'.capitalize, class: 'badge badge-success'
    else
      h.tag.span 'finished'.capitalize, class: 'badge badge-secondary'
    end
  end

end
