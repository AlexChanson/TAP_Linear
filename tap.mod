/*********************************************
 * OPL 12.10.0.0 Model
 * Author: alex
 * Creation Date: Aug 27, 2020 at 11:44:14 AM
 *********************************************/

// contrainte de poids et nombre de candidats
int nbObjet = ...;
int poidsMax = ...;


//déclarer un intervalle d'entiers de 1 à nbObjet
range objets = 1..nbObjet;

//infos sur les queries
int poids[objets] = ...;
int valeur[objets] = ...;
int distance[objets][objets] = ...;

 
//variables de décisions 0/1 si objet présent
dvar boolean x[objets][objets];

//modele
maximize
 sum(i in objets) valeur[i] * ( (sum(k in objets) x[k][i]) + (sum(k in objets) x[i][k]));
 
minimize
  sum(i in objets) sum(j in objets) distance[i][j] * x[i][j];

subject to {
sum( i in objets )
 poids[i] * ( (sum(k in objets) x[k][i]) + (sum(k in objets) x[i][k])) <= poidsMax;
 
sum( i in objets ) sum(j in (i+1)..nbObjet) x[i][j] <= 1;

sum( j in objets ) sum(i in (j+1)..nbObjet) x[i][j] <= 1;
}