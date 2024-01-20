import { useState, useEffect } from "react";
import axios from "axios";

export default function Exercie2() {
  const [count, setCount] = useState(0);
  const [code, setCode] = useState("");
  const [eleves, setEleves] = useState([]);
  const [formData, setFormData] = useState({ nom: "", age: "", group: "" });
  const [isFiltred, setIsFiltred] = useState(false);

  const handleChange = (event) => {
    setCode(event.target.value);
  };

  useEffect(() => {
    axios
      .get("https://run.mocky.io/v3/61c41eaf-a507-4d03-84d4-c9c08698703d")
      .then((res) => {
        setCount(res.data.length);
        setEleves(res.data);
      });
  }, [code]);

  const handleRecherce = (event) => {
    event.preventDefault();
    const eleve = eleves.find((e) => e.code === code);
    if (eleve) {
      setFormData(eleve);
      setEleves([eleve]);
    }
  };

  const handleFiltre = (event) => {
    event.preventDefault();
    setIsFiltred((prev) => !prev);
  };

  const handleInit = () => {
    setIsFiltred(false);
  };

  return (
    <div>
      <form>
        <h2>Nombre d'élèves: {count}</h2>
        <div>
          <label>Code: </label>
          <input name="code" value={code} onChange={handleChange} />
        </div>
        <div>
          <label>Nom: </label>
          <input name="nom" value={formData.Name} />
        </div>
        <div>
          <label>Age: </label>
          <input name="age" value={formData.Age} />
        </div>
        <div>
          <label>Groupe: </label>
          <input name="group" value={formData.Group} />
        </div>
        <button onClick={handleRecherce}>Rechercher</button>
        <button onClick={handleFiltre}>Filtrer</button>
        <button onClick={handleInit}>Initialiser</button>
      </form>

      <table>
        <tr>
          <th>Code</th>
          <th>Nom</th>
          <th>Age</th>
          <th>Groupe</th>
        </tr>
        {isFiltred
          ? eleves
              .filter((elm) => elm.Group === formData.Group)
              .map((elm) => {
                return (
                  <tr key={elm.code}>
                    <td>{elm.code}</td>
                    <td>{elm.Name}</td>
                    <td>{elm.Age}</td>
                    <td>{elm.Group}</td>
                  </tr>
                );
              })
          : eleves.map((el) => {
              return (
                <tr key={el.code}>
                  <td>{el.code}</td>
                  <td>{el.Name}</td>
                  <td>{el.Age}</td>
                  <td>{el.Group}</td>
                </tr>
              );
            })}
      </table>
    </div>
  );
}
