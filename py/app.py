from flask import Flask
from views import init_app_routes
from extensions import db, migrate
import os

# database vars
db_host = os.getenv("POSTGRES_HOST", None)
db_port = os.getenv("POSTGRES_PORT", None)
db_user = os.getenv("POSTGRES_USER", None)
db_password = os.getenv("POSTGRES_PASSWORD", None)
postgres_db =  os.getenv("POSTGRES_DB", None)

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = f"postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{postgres_db}"

if __name__ == "__main__":

    db.init_app(app)
    migrate.init_app(app, db)
    
    with app.app_context():
        db.create_all()

    init_app_routes(app, db)
    app.run(debug=True, host='0.0.0.0')
