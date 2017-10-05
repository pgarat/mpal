class PaymentRegistry < ApplicationRecord
  belongs_to :projet
  has_many   :payments, dependent: :destroy

  def demandeur
    projet.demandeur.fullname
  end

  def adresse
    projet.adresse.description
  end

  def plateforme_id
    projet.plateforme_id
  end

  def code_opal
    projet.opal_numero
  end

  def statuses
    payments.map(&:dashboard_status).join(" - ")
  end
end

