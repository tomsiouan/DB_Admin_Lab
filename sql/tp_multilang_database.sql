DROP TABLE IF EXISTS notes;
DROP TABLE IF EXISTS eleves;
DROP TABLE IF EXISTS matieres;

CREATE TABLE eleves (
    id_eleve SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_naissance DATE,
    promo VARCHAR(10) DEFAULT 'BUT3'
);

CREATE TABLE matieres (
    id_matiere SERIAL PRIMARY KEY,
    nom_matiere VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE notes (
    id_note SERIAL PRIMARY KEY,
    id_eleve INTEGER NOT NULL,
    id_matiere INTEGER NOT NULL,
    note DECIMAL(4,2) NOT NULL,
    date_evaluation DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_eleve
        FOREIGN KEY (id_eleve)
        REFERENCES eleves (id_eleve)
        ON DELETE CASCADE,
    CONSTRAINT fk_matiere
        FOREIGN KEY (id_matiere)
        REFERENCES matieres (id_matiere)
        ON DELETE RESTRICT,
    CONSTRAINT unique_note_eleve_matiere UNIQUE (id_eleve, id_matiere, date_evaluation)
);

INSERT INTO eleves (nom, prenom, date_naissance) VALUES
('Dubois', 'Théo', '2002-09-15'),
('Léger', 'Chloé', '2003-01-20'),
('Durand', 'Élodie', '2002-11-01'),
('Müller', 'François', '2003-03-25'),
('García', 'Sofía', '2002-07-10'),
('Dupond', 'Alice', '2002-05-12'),
('Tremblay', 'Jérôme', '2003-02-28');

INSERT INTO matieres (nom_matiere) VALUES
('Mathématiques'),
('Français'),
('Anglais'),
('Physique'),
('Informatique'),
('Histoire-Géographie'),
('Économie');

INSERT INTO notes (id_eleve, id_matiere, note) VALUES
( (SELECT id_eleve FROM eleves WHERE nom = 'Dubois' AND prenom = 'Théo'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Mathématiques'), 15.50),
( (SELECT id_eleve FROM eleves WHERE nom = 'Dubois' AND prenom = 'Théo'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Français'), 12.00),
( (SELECT id_eleve FROM eleves WHERE nom = 'Dubois' AND prenom = 'Théo'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Anglais'), 16.00);

INSERT INTO notes (id_eleve, id_matiere, note) VALUES
( (SELECT id_eleve FROM eleves WHERE nom = 'Léger' AND prenom = 'Chloé'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Mathématiques'), 18.00),
( (SELECT id_eleve FROM eleves WHERE nom = 'Léger' AND prenom = 'Chloé'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Français'), 14.50),
( (SELECT id_eleve FROM eleves WHERE nom = 'Léger' AND prenom = 'Chloé'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Physique'), 17.00);

INSERT INTO notes (id_eleve, id_matiere, note) VALUES
( (SELECT id_eleve FROM eleves WHERE nom = 'Durand' AND prenom = 'Élodie'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Mathématiques'), 13.00),
( (SELECT id_eleve FROM eleves WHERE nom = 'Durand' AND prenom = 'Élodie'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Anglais'), 15.50),
( (SELECT id_eleve FROM eleves WHERE nom = 'Durand' AND prenom = 'Élodie'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Informatique'), 16.50);

INSERT INTO notes (id_eleve, id_matiere, note) VALUES
( (SELECT id_eleve FROM eleves WHERE nom = 'Müller' AND prenom = 'François'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Français'), 11.00),
( (SELECT id_eleve FROM eleves WHERE nom = 'Müller' AND prenom = 'François'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Informatique'), 14.00),
( (SELECT id_eleve FROM eleves WHERE nom = 'Müller' AND prenom = 'François'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Histoire-Géographie'), 12.50);

INSERT INTO notes (id_eleve, id_matiere, note) VALUES
( (SELECT id_eleve FROM eleves WHERE nom = 'García' AND prenom = 'Sofía'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Mathématiques'), 17.00),
( (SELECT id_eleve FROM eleves WHERE nom = 'García' AND prenom = 'Sofía'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Anglais'), 18.50),
( (SELECT id_eleve FROM eleves WHERE nom = 'García' AND prenom = 'Sofía'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Informatique'), 19.00);

INSERT INTO notes (id_eleve, id_matiere, note) VALUES
( (SELECT id_eleve FROM eleves WHERE nom = 'Dupond' AND prenom = 'Alice'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Mathématiques'), 14.00),
( (SELECT id_eleve FROM eleves WHERE nom = 'Dupond' AND prenom = 'Alice'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Français'), 13.50),
( (SELECT id_eleve FROM eleves WHERE nom = 'Dupond' AND prenom = 'Alice'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Anglais'), 15.00);

INSERT INTO notes (id_eleve, id_matiere, note) VALUES
( (SELECT id_eleve FROM eleves WHERE nom = 'Tremblay' AND prenom = 'Jérôme'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Mathématiques'), 16.00),
( (SELECT id_eleve FROM eleves WHERE nom = 'Tremblay' AND prenom = 'Jérôme'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Français'), 17.00),
( (SELECT id_eleve FROM eleves WHERE nom = 'Tremblay' AND prenom = 'Jérôme'),
  (SELECT id_matiere FROM matieres WHERE nom_matiere = 'Anglais'), 16.50);


SELECT id_eleve, nom, prenom, promo FROM eleves ORDER BY nom, prenom;

SELECT id_matiere, nom_matiere FROM matieres ORDER BY nom_matiere;

SELECT
    e.nom,
    e.prenom,
    m.nom_matiere,
    n.note
FROM
    notes n
JOIN
    eleves e ON n.id_eleve = e.id_eleve
JOIN
    matieres m ON n.id_matiere = m.id_matiere
WHERE
    e.nom = 'Léger' AND e.prenom = 'Chloé'
ORDER BY
    m.nom_matiere;

SELECT
    e.nom AS nom_eleve,
    e.prenom AS prenom_eleve,
    m.nom_matiere,
    n.note,
    n.date_evaluation
FROM
    notes n
JOIN
    eleves e ON n.id_eleve = e.id_eleve
JOIN
    matieres m ON n.id_matiere = m.id_matiere
ORDER BY
    nom_eleve, prenom_eleve, nom_matiere;
