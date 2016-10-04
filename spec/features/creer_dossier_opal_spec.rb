require 'rails_helper'
require 'support/mpal_helper'
require 'support/opal_helper'

feature "creer dossier dans opal" do
  scenario "depuis la page projet" do
    instructeur = FactoryGirl.create(:intervenant, :instructeur)
    invitation = FactoryGirl.create(:invitation, intervenant: instructeur) 
    projet = invitation.projet

    visit projet_path(projet, jeton: invitation.token)
    click_button I18n.t('projets.visualisation.creer_dossier_opal')
    expect(page).to have_content(I18n.t("projets.creation_opal.messages.succes", id_opal: 959496))
  end

  scenario "en tant que demandeur" do
  end
end

