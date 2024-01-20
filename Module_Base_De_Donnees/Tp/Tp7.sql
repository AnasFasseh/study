#BD biblio
#Q1
select num_candidat,count(code_livre) from emprunte
group by num_candidat;
#Q2
select num_candidat from emprunte
group by num_candidat
having count(code_livre);
#Q3
select num_candidat from emprunte
group by livre
having count(livre) between 1 and 2;
#Q4
select code_editeur, avg(nbr_pages) as moyen_pages from livre
group by code_editeur;
#Q5
select code_editeur,avg(nbr_pages) as moyen_pages from livre
group by code_editeur
having avg(nbr_pages)>83;

#BD employe
#Q1
select poste, max(SAL) from EMP
group by POSTE
order by SAL;
#Q2
select dept, avg(SAL)as sal_moy from EMP
group by DEPT;
#Q3
select poste,dept, avg(SAL) from EMP
group by POSTE,DEPT;
#Q4
select POSTE from EMP
group by poste
having min(SAL)<9000;
#Q5
select poste, count(NOME) as nombre_employe from EMP
group by POSTE
order by SAL;
#Q6
select dept, count(matr) as nombre_employe from EMP
group by DEPT;
#Q7
select DEPT from EMP
group by dept
having count(NOME)=5;
#Q8
select POSTE from EMP
group by poste
having count(NOME) between 6 and 10;

#BD Vol
#Q1
select matricule from vol
group by numvol
having count(numvol)>5;
#Q2
select datediff(heure_arrivee,heure_depart) from vol
group by matricule;
#Q3
select numvol from vol
having avg(datediff(heure_arrivee,heure_depart))>2;
#Q4
select ville from pilote
group by nom
having count(nom)>=2;