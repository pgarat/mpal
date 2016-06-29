class Projet < ActiveRecord::Base
  validates :numero_fiscal, :reference_avis, :adresse, presence: true
  has_many :intervenants, through: :invitations
  has_many :invitations
  has_many :evenements, -> { order('evenements.quand DESC') }
  has_many :occupants
  has_many :commentaires, as: :auteur

  before_create :construit_evenement

  def construit_evenement
    self.evenements.build(label: 'creation_projet', quand: Time.now)
  end

  def intervenants_disponibles(role: nil)
    Intervenant.pour_departement(self.departement, role: role) - self.intervenants
  end

  def demandeur_principal
    self.occupants.where(demandeur:true).first
  end

  def usager
    occupant = self.demandeur_principal
    occupant.to_s if occupant
  end
end
