import React, { useState } from "react";
import "./form2.css";
function Form2() {
  const [formData, setFormData] = useState({
    user: "",
    password: "",
    date: "",
    ville: "",
    genre: "",
    sport: false,
    lecture: false,
    music: false,
  });
  const [card, setCard] = useState(false);

  const handlerChange = (event) => {
    const { name, value, type, checked } = event.target;
    setFormData((oldState) => {
      return {
        ...oldState,
        [name]: type === "checkbox" ? checked : value,
      };
    });
  };

  const handlerSubmit = (event) => {
    event.preventDefault();
    console.log(formData.date);
    setCard((oldCard) => !oldCard);
  };
  return (
    <div>
      {card ? (
        <div>
          <h2>
            Je suis {formData.user} né le {formData.date} à {formData.ville} et
            mes loisirs sont : {formData.sport}, {formData.lecture},{" "}
            {formData.music}
          </h2>
        </div>
      ) : (
        <form onSubmit={handlerSubmit} className="form-login">
          <div>
            <h2>Inscription</h2>
          </div>
          <div className="inputs-container">
            <label>L'identifiant : </label>

            <input name="user" value={formData.user} onChange={handlerChange} />
          </div>

          <div className="inputs-container">
            <label>Mot de passe : </label>

            <input
              name="password"
              value={formData.password}
              onChange={handlerChange}
            />
          </div>

          <div className="inputs-container">
            <label>Date de naissance : </label>

            <input
              name="date"
              type="date"
              value={formData.date}
              onChange={handlerChange}
            />
          </div>

          <div className="not-inputs">
            <label>Ville : </label>

            <select
              name="ville"
              type="date"
              value={formData.ville}
              onChange={handlerChange}
            >
              <option value=""></option>
              <option value="casablanca">Casablanca</option>
              <option value="marrakesh">Marrakesh</option>
              <option value="fes">Fes</option>
            </select>
          </div>

          <div className="not-inputs">
            <label>Genre : </label>

            <input
              name="genre"
              type="radio"
              value="homme"
              checked={formData.genre === "homme"}
              onChange={handlerChange}
            />
            <label>Homme</label>
            <input
              name="genre"
              type="radio"
              value="femme"
              checked={formData.genre === "femme"}
              onChange={handlerChange}
            />
            <label>Femme</label>
          </div>

          <div className="not-inputs">
            <label>Loisirs : </label>

            <input
              name="sport"
              type="checkbox"
              value="sport"
              checked={formData.sport}
              onChange={handlerChange}
            />
            <label>Sport</label>
            <input
              name="lecture"
              type="checkbox"
              value="lecture"
              checked={formData.lecture}
              onChange={handlerChange}
            />
            <label>Lecture</label>

            <input
              name="music"
              type="checkbox"
              value="music"
              checked={formData.music}
              onChange={handlerChange}
            />
            <label>Musique</label>
          </div>
          <div>
            <label>Photo</label>
            <input name="photo" type="file" />
          </div>
          <div>
            <button>S'inscrire</button>
          </div>
        </form>
      )}
    </div>
  );
}

export default Form2;
