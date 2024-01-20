import axios from 'axios';
import { useEffect, useState } from 'react';
function App() {
  const [eleves, setEleves] = useState([]);
  const [code, setCode] = useState('');
  const [nom, setNom] = useState('');
  const [age, setAge] = useState('');
  const [groupe, setGroupe] = useState('');
  const [feleves, setFeleves] = useState([]);
  useEffect(() => axios.get("https://run.mocky.io/v3/aaad4a55-6339-4b69-9940-5548e4014146").then((res) => { setEleves(res.data.eleves); setFeleves(res.data.eleves); }), []);
  function handlerClick() {
    const elvs = eleves.filter((elv) => elv.code === parseInt(code));
    const eleve = elvs[0];
    setFeleves(elvs);
    if (eleve) {
      setNom(eleve.nom);
      setAge(eleve.age);
      setGroupe(eleve.Groupe);
    }
    else {
      setNom('');
      setAge('');
      setGroupe('');
      alert('Ce code n\'existe pas!');
    }
  }
  function filtrer() {
    const elvs = eleves.filter((elv) => elv.Groupe === groupe);
    setFeleves(elvs);
  }
  return <div>
    <h1>Nombre d'élèves {eleves.length}</h1>
    <form onSubmit={(e) => e.preventDefault()}>
      <p>Code:<input type="text" value={code} onChange={(e) => setCode(e.target.value)} /></p>
      <p>Nom:<input type="text" value={nom} onChange={(e) => setNom(e.target.value)} /></p>
      <p>Age:<input type="text" value={age} onChange={(e) => setAge(e.target.value)} /></p>
      <p>Groupe:<input type="text" value={groupe} onChange={(e) => setGroupe(e.target.value)} /></p>
      <button onClick={() => handlerClick()}>Rechercher</button>
      <button onClick={() => filtrer()}>Filtrer</button>
      <button onClick={() => setFeleves(eleves)}>Initialiser</button>
    </form>
    <table border="1">
      <tr>
        <th>Code</th>
        <th>Nom</th>
        <th>Age</th>
        <th>Groupe</th>
      </tr>
      {
        feleves.map((eleve, index) => <tr key={index}>
          <td>{eleve.code}</td>
          <td>{eleve.nom}</td>
          <td>{eleve.age}</td>
          <td>{eleve.Groupe}</td>
        </tr>)
      }
    </table>
  </div>
}
export default App;
