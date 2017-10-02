module GrantsHelper

  def edit_grant_button
    return nil if cannot? :edit, @grant
    return link_to "Edit",
                   edit_grant_path(@grant),
                   class: 'btn btn-block btn-primary'
  end

end
