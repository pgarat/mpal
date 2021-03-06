class Demande < ApplicationRecord
  belongs_to :projet

  validate :validate_theme_existence

  REQUIRED_ATTRIBUTES = [
    :changement_chauffage,
    :froid,
    :probleme_deplacement,
    :accessibilite,
    :hospitalisation,
    :adaptation_salle_de_bain,
    :arrete,
    :saturnisme,
    :autre,
    :travaux_fenetres,
    :travaux_isolation,
    :travaux_chauffage,
    :travaux_adaptation_sdb,
    :travaux_monte_escalier,
    :travaux_amenagement_ext,
    :travaux_autres
  ]

  def complete?
    required_attributes_as_string = REQUIRED_ATTRIBUTES.map(&:to_s)
    attributes.slice(*required_attributes_as_string).values.any? { |v| v == true }
  end

  def is_about_energy?
    !!(changement_chauffage || froid || travaux_fenetres || travaux_isolation || travaux_chauffage)
  end

  def is_about_self_sufficiency?
    !!(probleme_deplacement || accessibilite || hospitalisation || adaptation_salle_de_bain || travaux_adaptation_sdb || travaux_monte_escalier || travaux_amenagement_ext)
  end

  def is_about_unhealthiness?
    !!(arrete || saturnisme)
  end

  def has_a_theme?
    is_about_energy? || is_about_self_sufficiency? || is_about_unhealthiness?
  end

  def validate_theme_existence
    unless has_a_theme?
      errors[:base] << I18n.t("demarrage_projet.demande.erreurs.besoin_obligatoire")
    end
  end
end

