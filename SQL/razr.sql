select razr1.k "1 ����.",razr2.k "2 ����.",
razr3.k "3 ����.",razr4.k "4 ����.",razr5.k "5 ����.",
razr6.k "6 ����.",razr7.k "7 ����.", norazr.k "��� ����.", vse.k "���"
from 
(select sum(kolshtated) k from mshtat
where datavvoda is not null
and datavivod is null
and razr=1) razr1,
(select sum(kolshtated) k from mshtat
where datavvoda is not null
and datavivod is null
and razr=2) razr2,
(select sum(kolshtated) k from mshtat
where datavvoda is not null
and datavivod is null
and razr=3) razr3,
(select sum(kolshtated) k from mshtat
where datavvoda is not null
and datavivod is null
and razr=4) razr4,
(select sum(kolshtated) k from mshtat
where datavvoda is not null
and datavivod is null
and razr=5) razr5,
(select sum(kolshtated) k from mshtat
where datavvoda is not null
and datavivod is null
and razr=6) razr6,
(select sum(kolshtated) k from mshtat
where datavvoda is not null
and datavivod is null
and razr=7) razr7,
(select sum(kolshtated) k from mshtat
where datavvoda is not null
and datavivod is null
and razr is null) norazr,
(select sum(kolshtated) k from mshtat
where datavvoda is not null
and datavivod is null) vse