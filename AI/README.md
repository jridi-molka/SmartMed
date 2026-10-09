# SmartMed — Module IA

Ce dossier contient tout ce qui concerne l'intelligence artificielle du projet : données, préparation des données et futurs modèles.

> **Sprint 1 (actuel)** : définir les données et les variables (features), créer des données simulées, les nettoyer, préparer l'architecture.
> **Sprint 6** : entraîner et intégrer les modèles dans le backend FastAPI.

---

## 1. Structure du dossier

```
AI/
├── data/             # Données brutes et générées (fichiers CSV) + script generate_data.py
├── preprocessing/    # Scripts de nettoyage et de préparation des données
├── recommendation/   # Module de recommandation de médecins (Sprint 6)
├── waiting_time/     # Module de prédiction du temps d'attente (Sprint 6)
├── sentiment/        # Module d'analyse des avis (Sprint 6)
├── requirements.txt  # Bibliothèques Python nécessaires
└── README.md         # Ce document
```

| Dossier | Rôle |
|---|---|
| `data` | Stocke les jeux de données. Contient le script qui génère les données simulées. |
| `preprocessing` | Transforme les données brutes en données propres et utilisables par les modèles. |
| `recommendation` | Calcule un score pour proposer les meilleurs médecins à un patient. |
| `waiting_time` | Estime combien de minutes un patient va attendre. |
| `sentiment` | Détermine si un avis est positif, neutre ou négatif et repère les thèmes récurrents. |

---

## 2. Vocabulaire

- **Feature (variable)** : une information donnée au modèle pour qu'il prenne sa décision (ex. : nombre de patients dans la file).
- **Cible (target)** : ce que le modèle doit deviner (ex. : le temps d'attente réel en minutes).
- **Dataset** : un tableau de données (un fichier CSV) dont chaque ligne est un exemple.
- **Données simulées (synthétiques)** : données générées par du code, car les vraies données médicales sont confidentielles.

---

## 3. Les trois modules et leurs variables

### 3.1 Recommandation de médecins (BF24)

**Question** : quel médecin proposer à ce patient ?

| Feature | Description | Type |
|---|---|---|
| `specialty` | Spécialité du médecin | catégorie |
| `distance_km` | Distance entre le patient et le médecin | nombre |
| `avg_rating` | Note moyenne (1 à 5) | nombre |
| `reviews_count` | Nombre d'avis reçus | entier |
| `next_available_hours` | Délai avant le prochain créneau libre | nombre |
| `avg_wait_minutes` | Temps d'attente moyen habituel | nombre |

**Sortie** : un score entre 0 et 1 pour chaque médecin. Le plus haut score est proposé en premier.

### 3.2 Prédiction du temps d'attente (BF26)

**Question** : combien de temps vais-je attendre ?

| Feature | Description | Type |
|---|---|---|
| `patients_before` | Nombre de patients avant moi dans la file | entier |
| `avg_consultation_min` | Durée moyenne d'une consultation du médecin | nombre |
| `hour_of_day` | Heure de la journée (0 à 23) | entier |
| `day_of_week` | Jour de la semaine (0 = lundi) | entier |
| `doctor_avg_delay_min` | Retard moyen historique du médecin | nombre |

**Cible** : `actual_wait_min`, le temps d'attente réel en minutes.

### 3.3 Analyse des avis (BF25)

**Question** : cet avis est-il positif, neutre ou négatif ?

| Donnée | Description | Type |
|---|---|---|
| `comment` | Texte de l'avis | texte |
| `rating` | Note donnée (1 à 5) | entier |

**Cible** : `sentiment` (`positive`, `neutral`, `negative`).
Thèmes à repérer : attente, accueil, prix, qualité des soins, propreté.

---

## 4. Jeux de données

Fichiers générés par `data/generate_data.py`. Les noms de colonnes sont en `snake_case` et doivent rester **identiques** à ceux de la base PostgreSQL (ex. : `doctor_id`, pas `doctorId`).

### `doctors.csv`
| Colonne | Type | Exemple |
|---|---|---|
| `doctor_id` | entier | 12 |
| `name` | texte | Dr. Ben Salah |
| `specialty` | texte | Cardiologue |
| `latitude` | nombre | 36.8065 |
| `longitude` | nombre | 10.1815 |
| `avg_rating` | nombre (1 à 5) | 4.3 |
| `reviews_count` | entier | 58 |
| `avg_consultation_min` | nombre | 20 |

### `reviews.csv`
| Colonne | Type | Exemple |
|---|---|---|
| `review_id` | entier | 301 |
| `doctor_id` | entier | 12 |
| `rating` | entier (1 à 5) | 2 |
| `comment` | texte | Trop d'attente, médecin sympathique |
| `sentiment` | texte | negative |

### `waiting_history.csv`
| Colonne | Type | Exemple |
|---|---|---|
| `record_id` | entier | 1050 |
| `doctor_id` | entier | 12 |
| `patients_before` | entier | 4 |
| `avg_consultation_min` | nombre | 20 |
| `hour_of_day` | entier | 10 |
| `day_of_week` | entier | 2 |
| `actual_wait_min` | nombre | 87 |

---

## 5. Règles de nettoyage (preprocessing)

- Supprimer les doublons.
- Traiter les valeurs manquantes (suppression ou remplacement).
- Vérifier que `rating` est entre 1 et 5.
- Vérifier que `patients_before` et `actual_wait_min` ne sont pas négatifs.
- Vérifier que `latitude` et `longitude` sont des valeurs valides.
- Uniformiser le texte des commentaires (espaces, casse).

---

## 6. Livrables du Sprint 1

- [ ] Features définies pour les 3 modules (ce document)
- [ ] Données simulées générées (`data/generate_data.py`)
- [ ] Script de nettoyage (`preprocessing/`)
- [ ] Première étude des variables (notebook : graphiques et corrélations)
- [ ] Architecture du module IA (ce document)

---

## 7. Installation

```bash
cd AI
python -m venv venv
source venv/Scripts/activate      # Git Bash sous Windows
# venv\Scripts\activate           # PowerShell / CMD sous Windows
pip install -r requirements.txt
```

## 8. Règles d'équipe

- Ne jamais commiter `venv/`, `.env`, clés ou mots de passe.
- Ne pas modifier un nom de colonne sans prévenir l'équipe Backend.
- Travailler sur la branche `feature/ai-foundation`, puis ouvrir une Pull Request.
