use gestion_stg;
#Q1
select * from stagiaires where NumS in(select distinct NumS from passerexamen);
#Q2
select * from stagiaires where NumS not in(select distinct NumS from passerexamen);
#Q3
select NumS,avg(note) from passerexamen group by NumS having avg(note)>All(select avg(note) from passerexamen);
#Q4
select * from stagiaires where NumS in (select NumS,avg(note) from passerexamen group by NumS having avg(note)>All(select avg(note) from passerexamen));
#Q5
select NumE from passerexamen group by NumE having avg(Note)>=All(select avg(Note) from passerexamen group by NumE);
#Q6
select NumS from passerexamen group by NumS having count(NumE)=(select count(NumE) from examens);
#Q7
select NumS from passerexamen group by NumS having count(NumE)<(select count(NumE) from examens);
#Q8
select NumS from passerexamen group by NumS having avg(note)<Any (select avg(note) from passerexamen group by NumE);
#Q9
select NumS from passerexamen group by NumS having count(NumE)=(select count(NumE)-3 from examens);
#Q10
select salle from examens group by salle having count(NumE)>=All(select count(NumE) from examens group by salle);
#Q11
select salle from examens where TypeE='P' group by salle having count(NumE)>=All(select count(NumE) from examens where TypeE='P' group by salle);

use Biblio;
#Q1
select code_livre,nom_livre from livre where nbr_pages=(select max(nbr_pages) from livre);
#Q2
select code_livre,nom_livre from livre where nbr_pages=(select min(nbr_pages) from livre);
#Q3
select code_livre,nom_livre from livre where nbr_pages>=(select avg(nbr_pages) from livre);
#Q4
select distinct code_editeur from livre where code_livre in (select code_livre from emprunter);
#Q5
select * from livre where nbr_pages>Any(select nbr_pages from livre where code_editeur=1233);
#Q6
select code_livre from emprunter group by code_livre having count(code_livre)>=All(select count(code_livre) from livre group by code_livre);
#Q7
select num_candidat from emprunter group by num_candidat having count(code_livre)>=All(select count(code_livre) from livre group by code_livre);
#Q8
select num_candidat from emprunter group by num_candidat having count(code_livre)=(select count(code_livre) from livre);

use DBEmployee;
#Q1
select NOME from EMP where POSTE=(select POSTE from EMP where NOME='BIRAUD');
#Q2
select * from EMP where DATEMB<=All(select DATEMB from EMP group by NOME);
#Q3
select NOME from EMP where DATEMB<=All(select DATEMB from EMP where DEPT=20 group by NOME);
#Q4
select POSTE,avg(SAL) from EMP group by POSTE having avg(SAL)<=All(select avg(SAL) from EMP group by POSTE);
#Q5
select SAL,NOME from EMP group by NOME having COMM>=Any (select COMM from EMP where POSTE='INGENIEUR' group by NOME);
#Q6
select SAL,NOME,COMM from EMP group by NOME having COMM>=All (select COMM from EMP where POSTE='INGENIEUR' group by NOME);
#Q7
select DEPT from DEPT where DEPT not in (select DEPT from EMP);