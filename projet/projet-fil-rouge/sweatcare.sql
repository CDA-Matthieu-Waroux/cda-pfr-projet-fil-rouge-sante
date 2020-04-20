CREATE TABLE Besoin(
   IdBesoins VARCHAR(50),
   libell�Besoin VARCHAR(50) NOT NULL,
   PRIMARY KEY(IdBesoins)
);

CREATE TABLE R�le(
   IdRole BYTE,
   nomR�le VARCHAR(13) NOT NULL UNIQUE,
   PRIMARY KEY(IdRole)
);

CREATE TABLE Rubrique(
   IdType INT,
   libell�R VARCHAR(50) NOT NULL,
   PRIMARY KEY(IdType)
);

CREATE TABLE Lien(
   IdLien INT,
   libell�L VARCHAR(50) NOT NULL,
   description TEXT NOT NULL,
   IdType INT NOT NULL,
   PRIMARY KEY(IdLien),
   FOREIGN KEY(IdType) REFERENCES Rubrique(IdType)
);

CREATE TABLE TypeRepertoire(
   idtypeR INT,
   libell�TypeR VARCHAR(10) NOT NULL UNIQUE,
   PRIMARY KEY(idtypeR)
);

CREATE TABLE Adresse(
   idAdresse INT,
   numRue INT NOT NULL,
   rue VARCHAR(50) NOT NULL,
   CP INT NOT NULL,
   Ville VARCHAR(50) NOT NULL,
   compl�mentAd VARCHAR(50) NOT NULL,
   PRIMARY KEY(idAdresse)
);

REATE TABLE Profession(
   idPro INT,
   sp�cialit� VARCHAR(50),
   PRIMARY KEY(idPro)
);C

CREATE TABLE Titre(
   idTitre INT,
   libell�Titre VARCHAR(20) NOT NULL,
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
   libell�Patho VARCHAR(50) NOT NULL,
   PRIMARY KEY(idPatho)
);

CREATE TABLE Habitus(
   idHabitus INT,
   libell�Hab VARCHAR(50) NOT NULL,
   PRIMARY KEY(idHabitus)
);

CREATE TABLE Typettt(
   idTypeTtt INT,
   sp�cialit�Ttt VARCHAR(50) NOT NULL,
   d�butTtt DATE NOT NULL,
   dur�eTtt VARCHAR(50),
   PRIMARY KEY(idTypeTtt)
);

CREATE TABLE Patient(
   idPatient INT,
   IdPatient_1 INT NOT NULL,
   Nom_patient VARCHAR(50) NOT NULL,
   Pr�nomP VARCHAR(50) NOT NULL,
   DateNaissance DATE NOT NULL,
   idGenre INT NOT NULL,
   PRIMARY KEY(idPatient),
   FOREIGN KEY(idGenre) REFERENCES Genre(idGenre)
);

CREATE TABLE Professionnel(
   Id_professionnel VARCHAR(50),
   NomPro VARCHAR(50) NOT NULL,
   Pr�nomPro VARCHAR(50) NOT NULL,
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
   FOREIGN KEY(IdRole) REFERENCES R�le(IdRole)
);

CREATE TABLE Agenda(
   IdAgenda INT,
   ann�e DATE NOT NULL,
   semaine DATE NOT NULL,
   RDV DATETIME NOT NULL,
   N_Compte INT NOT NULL,
   PRIMARY KEY(IdAgenda),
   FOREIGN KEY(N_Compte) REFERENCES Utilisateur(N_Compte)
);

CREATE TABLE R�pertoire(
   IdR�pertoire VARCHAR(50),
   idtypeR INT NOT NULL,
   N_Compte INT NOT NULL,
   PRIMARY KEY(IdR�pertoire),
   FOREIGN KEY(idtypeR) REFERENCES TypeRepertoire(idtypeR),
   FOREIGN KEY(N_Compte) REFERENCES Utilisateur(N_Compte)
);

CREATE TABLE Solution(
   idsolution INT,
   libell�S VARCHAR(50) NOT NULL,
   IdType INT NOT NULL,
   PRIMARY KEY(idsolution),
   FOREIGN KEY(IdType) REFERENCES Rubrique(IdType)
);

CREATE TABLE Conseils(
   IdConseil INT,
   libell�C VARCHAR(50) NOT NULL,
   description TEXT NOT NULL,
   Id_professionnel VARCHAR(50) NOT NULL,
   IdType INT NOT NULL,
   PRIMARY KEY(IdConseil),
   FOREIGN KEY(Id_professionnel) REFERENCES Professionnel(Id_professionnel),
   FOREIGN KEY(IdType) REFERENCES Rubrique(IdType)
);

CREATE TABLE traitement(
   id_ttt INT,
   libell�Ttt VARCHAR(50) NOT NULL,
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
   IdR�pertoire VARCHAR(50),
   PRIMARY KEY(Id_professionnel, IdR�pertoire),
   FOREIGN KEY(Id_professionnel) REFERENCES Professionnel(Id_professionnel),
   FOREIGN KEY(IdR�pertoire) REFERENCES R�pertoire(IdR�pertoire)
);

CREATE TABLE acc�der(
   idPatient INT,
   IdR�pertoire VARCHAR(50),
   PRIMARY KEY(idPatient, IdR�pertoire),
   FOREIGN KEY(idPatient) REFERENCES Patient(idPatient),
   FOREIGN KEY(IdR�pertoire) REFERENCES R�pertoire(IdR�pertoire)
);

CREATE TABLE solutionner(
   IdBesoins VARCHAR(50),
   idsolution INT,
   PRIMARY KEY(IdBesoins, idsolution),
   FOREIGN KEY(IdBesoins) REFERENCES Besoin(IdBesoins),
   FOREIGN KEY(idsolution) REFERENCES Solution(idsolution)
);

CREATE TABLE �prouver(
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

CREATE TABLE r�sider(
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
   Fr�quence VARCHAR(30) NOT NULL,
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


