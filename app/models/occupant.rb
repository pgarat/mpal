class Occupant < ActiveRecord::Base
  belongs_to :projet
  validates :nom, :prenom, :date_de_naissance, presence: true
  enum civilite: [ 'mr', 'mme']

end