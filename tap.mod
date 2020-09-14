/*********************************************
 * OPL 12.10.0.0 Model
 * Author: alex
 * Creation Date: Aug 27, 2020 at 11:44:14 AM
 *********************************************/

// contrainte de poids et nombre de candidats
int nbObjet = ...;
int poidsMax = 500;


//déclarer un intervalle d'entiers de 1 à nbObjet
range objets = 1..nbObjet;

//infos sur les queries
int poids[objets] = ...;
int valeur[objets] = ...;
int distance[objets][objets] = ...;

 
//variables de décisions 0/1 si objet présent
dvar boolean x[0..nbObjet+1][0..nbObjet+1];
dvar boolean s[objets];

// Model

// Objectives
//maximize sum(i in objets) valeur[i] * ( (sum(k in objets) x[k][i]) + (sum(k in objets) x[i][k]));// (2) 
maximize - sum(i in objets) sum(j in objets) distance[i][j] * x[i][j];// (2)


//Constraints see Overleaf
subject to {
sum( i in objets ) poids[i] * s[i] <= poidsMax; // (5)
 
forall(i in objets) sum(j in 0..nbObjet+1) x[i][j] <= 1;// (3)

forall( i in objets ) sum(j in 0..nbObjet+1) x[j][i] <= 1;// (4)

forall (i in objets) sum(j in 0..nbObjet+1) x[i][j] == sum(j in 0..nbObjet+1) x[j][i];//6()

forall (i in objets) sum(j in 0..nbObjet+1) x[i][j] == s[i];// (7)
  
//temp fix
forall (i in objets) x[i][i] == 0;

sum(i in objets) x[0][i] == 1;// (8)
sum(i in objets) x[i][0] == 0;

sum(i in objets) x[i][nbObjet+1] == 1;// (8)
sum(i in objets) x[nbObjet+1][i] == 0;

//epsilon-consraint on the Knapsack objective
sum(i in objets) s[i]*valeur[i] >= 80;

}