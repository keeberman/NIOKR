select razr1.k "1 разр.",razr2.k "2 разр.",
razr3.k "3 разр.",razr4.k "4 разр.",razr5.k "5 разр.",
razr6.k "6 разр.",razr7.k "7 разр.", norazr.k "Без разр.", vse.k "Все"
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