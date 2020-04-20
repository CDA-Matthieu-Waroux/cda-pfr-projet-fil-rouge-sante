CREATE TABLE Besoin(
   IdBesoins VARCHAR(50),
   libelléBesoin VARCHAR(50) NOT NULL,
   PRIMARY KEY(IdBesoins)
);

CREATE TABLE Rôle(
   IdRole BYTE,
   nomRôle VARCHAR(13) NOT NULL UNIQUE,
   PRIMARY KEY(IdRole)
);

CREATE TABLE Rubrique(
   IdType INT,
   libelléR VARCHAR(50) NOT NULL,
   PRIMARY KEY(IdType)
);

CREATE TABLE Lien(
   IdLien INT,
   libelléL VARCHAR(50) NOT NULL,
   description TEXT NOT NULL,
   IdType INT NOT NULL,
   PRIMARY KEY(IdLien),
   FOREIGN KEY(IdType) REFERENCES Rubrique(IdType)
);

CREATE TABLE TypeRepertoire(
   idtypeR INT,
   libelléTypeR VARCHAR(10) NOT NULL UNIQUE,
   PRIMARY KEY(idtypeR)
);

CREATE TABLE Adresse(
   idAdresse INT,
   numRue INT NOT NULL,
   rue VARCHAR(50) NOT NULL,
   CP INT NOT NULL,
   Ville VARCHAR(50) NOT NULL,
   complémentAd VARCHAR(50) NOT NULL,
   PRIMARY KEY(idAdresse)
);

REATE TABLE Profession(
   idPro INT,
   spécialité VARCHAR(50),
   PRIMARY KEY(idPro)
);C

CREATE TABLE Titre(
   idTitre INT,
   libelléTitre VARCHAR(20) NOT NULL,
   PRIMARY KEY(idTitre)
);

CREATE TABLE Genre(
   idGenre INT,
   Sexe VARCHAR(20) NOT NULL,
   PRIMARY KEY(idGenre)
);

CREATE TABLE RDV(
   idRDV INT,
   DateRdv DATETIME NOT NULL,
   PRIMARY KEY(idRDV)
);

CREATE TABLE TypePatho(
   idPatho INT,
   libelléPatho VARCHAR(50) NOT NULL,
   PRIMARY KEY(idPatho)
);

CREATE TABLE Habitus(
   idHabitus INT,
   libelléHab VARCHAR(50) NOT NULL,
   PRIMARY KEY(idHabitus)
);

CREATE TABLE Typettt(
   idTypeTtt INT,
   spécialitéTtt VARCHAR(50) NOT NULL,
   débutTtt DATE NOT NULL,
   duréeTtt VARCHAR(50),
   PRIMARY KEY(idTypeTtt)
);

CREATE TABLE Patient(
   idPatient INT,
   IdPatient_1 INT NOT NULL,
   Nom_patient VARCHAR(50) NOT NULL,
   PrénomP VARCHAR(50) NOT NULL,
   DateNaissance DATE NOT NULL,
   idGenre INT NOT NULL,
   PRIMARY KEY(idPatient),
   FOREIGN KEY(idGenre) REFERENCES Genre(idGenre)
);

CREATE TABLE Professionnel(
   Id_professionnel VARCHAR(50),
   NomPro VARCHAR(50) NOT NULL,
   PrénomPro VARCHAR(50) NOT NULL,
   idGenre INT NOT NULL,
   idTitre INT NOT NULL,
   PRIMARY KEY(Id_professionnel),
   FOREIGN KEY(idGenre) REFERENCES Genre(idGenre),
   FOREIGN KEY(idTitre) REFERENCES Titre(idTitre)
);

CREATE TABLE Utilisateur(
   N_Compte INT,
   login VARCHAR(50) NOT NULL UNIQUE,
   pwd VARCHAR(50) NOT NULL,
   IdRole BYTE NOT NULL,
   PRIMARY KEY(N_Compte),
   FOREIGN KEY(IdRole) REFERENCES Rôle(IdRole)
);

CREATE TABLE Agenda(
   IdAgenda INT,
   année DATE NOT NULL,
   semaine DATE NOT NULL,
   RDV DATETIME NOT NULL,
   N_Compte INT NOT NULL,
   PRIMARY KEY(IdAgenda),
   FOREIGN KEY(N_Compte) REFERENCES Utilisateur(N_Compte)
);

CREATE TABLE Répertoire(
   IdRépertoire VARCHAR(50),
   idtypeR INT NOT NULL,
   N_Compte INT NOT NULL,
   PRIMARY KEY(IdRépertoire),
   FOREIGN KEY(idtypeR) REFERENCES TypeRepertoire(idtypeR),
   FOREIGN KEY(N_Compte) REFERENCES Utilisateur(N_Compte)
);

CREATE TABLE Solution(
   idsolution INT,
   libelléS VARCHAR(50) NOT NULL,
   IdType INT NOT NULL,
   PRIMARY KEY(idsolution),
   FOREIGN KEY(IdType) REFERENCES Rubrique(IdType)
);

CREATE TABLE Conseils(
   IdConseil INT,
   libelléC VARCHAR(50) NOT NULL,
   description TEXT NOT NULL,
   Id_professionnel VARCHAR(50) NOT NULL,
   IdType INT NOT NULL,
   PRIMARY KEY(IdConseil),
   FOREIGN KEY(Id_professionnel) REFERENCES Professionnel(Id_professionnel),
   FOREIGN KEY(IdType) REFERENCES Rubrique(IdType)
);

CREATE TABLE traitement(
   id_ttt INT,
   libelléTtt VARCHAR(50) NOT NULL,
   idTypeTtt INT NOT NULL,
   PRIMARY KEY(id_ttt),
   FOREIGN KEY(idTypeTtt) REFERENCES Typettt(idTypeTtt)
);

CREATE TABLE souffrir(
   idPatient INT,
   idPatho INT,
   PRIMARY KEY(idPatient, idPatho),
   FOREIGN KEY(idPatient) REFERENCES Patient(idPatient),
   FOREIGN KEY(idPatho) REFERENCES TypePatho(idPatho)
);

CREATE TABLE ressentir(
   IdBesoins VARCHAR(50),
   N_Compte INT,
   PRIMARY KEY(IdBesoins, N_Compte),
   FOREIGN KEY(IdBesoins) REFERENCES Besoin(IdBesoins),
   FOREIGN KEY(N_Compte) REFERENCES Utilisateur(N_Compte)
);

CREATE TABLE chercher(
   Id_professionnel VARCHAR(50),
   IdRépertoire VARCHAR(50),
   PRIMARY KEY(Id_professionnel, IdRépertoire),
   FOREIGN KEY(Id_professionnel) REFERENCES Professionnel(Id_professionnel),
   FOREIGN KEY(IdRépertoire) REFERENCES Répertoire(IdRépertoire)
);

CREATE TABLE accéder(
   idPatient INT,
   IdRépertoire VARCHAR(50),
   PRIMARY KEY(idPatient, IdRépertoire),
   FOREIGN KEY(idPatient) REFERENCES Patient(idPatient),
   FOREIGN KEY(IdRépertoire) REFERENCES Répertoire(IdRépertoire)
);

CREATE TABLE solutionner(
   IdBesoins VARCHAR(50),
   idsolution INT,
   PRIMARY KEY(IdBesoins, idsolution),
   FOREIGN KEY(IdBesoins) REFERENCES Besoin(IdBesoins),
   FOREIGN KEY(idsolution) REFERENCES Solution(idsolution)
);

CREATE TABLE éprouver(
   idPatient INT,
   IdBesoins VARCHAR(50),
   PRIMARY KEY(idPatient, IdBesoins),
   FOREIGN KEY(idPatient) REFERENCES Patient(idPatient),
   FOREIGN KEY(IdBesoins) REFERENCES Besoin(IdBesoins)
);

CREATE TABLE cntnr(
   IdAgenda INT,
   idRDV INT,
   PRIMARY KEY(IdAgenda, idRDV),
   FOREIGN KEY(IdAgenda) REFERENCES Agenda(IdAgenda),
   FOREIGN KEY(idRDV) REFERENCES RDV(idRDV)
);

CREATE TABLE habiter(
   Id_professionnel VARCHAR(50),
   idAdresse INT,
   PRIMARY KEY(Id_professionnel, idAdresse),
   FOREIGN KEY(Id_professionnel) REFERENCES Professionnel(Id_professionnel),
   FOREIGN KEY(idAdresse) REFERENCES Adresse(idAdresse)
);

CREATE TABLE résider(
   idPatient INT,
   idAdresse INT,
   PRIMARY KEY(idPatient, idAdresse),
   FOREIGN KEY(idPatient) REFERENCES Patient(idPatient),
   FOREIGN KEY(idAdresse) REFERENCES Adresse(idAdresse)
);

CREATE TABLE exercer(
   Id_professionnel VARCHAR(50),
   idPro INT,
   PRIMARY KEY(Id_professionnel, idPro),
   FOREIGN KEY(Id_professionnel) REFERENCES Professionnel(Id_professionnel),
   FOREIGN KEY(idPro) REFERENCES Profession(idPro)
);

CREATE TABLE habituer(
   idPatient INT,
   idHabitus INT,
   Fréquence VARCHAR(30) NOT NULL,
   PRIMARY KEY(idPatient, idHabitus),
   FOREIGN KEY(idPatient) REFERENCES Patient(idPatient),
   FOREIGN KEY(idHabitus) REFERENCES Habitus(idHabitus)
);

CREATE TABLE traiter(
   idPatho INT,
   id_ttt INT,
   PRIMARY KEY(idPatho, id_ttt),
   FOREIGN KEY(idPatho) REFERENCES TypePatho(idPatho),
   FOREIGN KEY(id_ttt) REFERENCES traitement(id_ttt)
);


