import { useNavigate } from "react-router-dom";

export default function ProductCard({src,title,price,width,id}) {
  const navigate= useNavigate()
  return (
    <div className="" onClick={_ =>{ if(!width) {navigate(`product/${id}`)}}}>
      <div className="card shadow-sm" style={{width : `${width}px`}}>
        <img
          className="bd-placeholder-img card-img-top"
          src={src}
          alt=""
        />
        <div className="card-body" >
          <p className="card-title">{title}</p>
          <p className="card-text">{price}</p>
          <div className="d-flex justify-content-between align-items-center">
            <div className="btn-group">
              <button
                type="button"
                className="btn btn-sm btn-outline-secondary"
              >
                Ajouter au panier
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
