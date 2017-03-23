package com.example.manon.ngl_studio_manon_hassnaoui;

        import android.content.Context;
        import android.os.AsyncTask;
        import android.support.v7.app.AppCompatActivity;
        import android.os.Bundle;
        import android.util.Log;
        import android.view.View;
        import android.widget.EditText;
        import android.widget.Toast;

        import org.json.JSONException;
        import org.json.JSONObject;

        import java.io.BufferedReader;
        import java.io.InputStreamReader;
        import java.net.HttpURLConnection;
        import java.net.URL;
        import java.net.URLEncoder;

public class inscription_activity extends AppCompatActivity {

    EditText textPseudo, textMdp;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_inscription_activity);

        textPseudo = (EditText) findViewById(R.id.creation_pseudo);
        textMdp = (EditText) findViewById(R.id.creation_mdp);
    }

    //Sur le click inscription on récupère les données dans les champs textPseudo et textMdp
    //devrait les envoyer dans la base de données
    public  void inscription_click(View v){
        String pseudo=textPseudo.getText().toString();
        String mdp=textMdp.getText().toString();

        new inscription(inscription_activity.this).execute(pseudo, mdp);
    }

    public class inscription extends AsyncTask<String, Void, String> {
 private Context context;

        public inscription(Context context) {
            this.context = context;
        }
        /*
        recoit le Json de doInBackground
         */
        @Override
        protected void onPostExecute(String result){
            String jsonStr = result;
            if (jsonStr == null){
                try {
                    JSONObject jsonObj = new JSONObject(jsonStr);
                    String query_result = jsonObj.getString("query_result");
                    if (query_result.equals("SUCCESS")){
                        Toast.makeText(context, "Inscription réussie !", Toast.LENGTH_SHORT).show();
                    } else if (query_result.equals("FAILURE")){
                        Toast.makeText(context, "L'inscritpion n'a pas aboutie !", Toast.LENGTH_SHORT).show();
                    } else {
                        Toast.makeText(context, "Echec de la connexion à la base externe", Toast.LENGTH_SHORT).show();
                    }
                }catch (JSONException e){
                    e.printStackTrace();
                    Toast.makeText(context, "Aucune donnée JSON !", Toast.LENGTH_SHORT).show();
                }
            }
        }


/*
valeur ex
 */
        @Override
        protected String doInBackground(String ... arg0){
            String pseudo_utilisateur = arg0[0];
            String mdp_utilisateur = arg0[1];

            String link;
            String data;
            BufferedReader bufferedReader;
            String result;

            try {
                data = "?pseudo=" + URLEncoder.encode(pseudo_utilisateur, "UTF-8");
                data += "&password=" + URLEncoder.encode(mdp_utilisateur, "UTF-8");

                link = "http://10.0.2.2/BbddWebService/db_signup.php"+data;
                URL url = new URL(link);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();

                bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()));
                result = bufferedReader.readLine().toString();
                Log.d("resultat", result);

                return result;
            }catch (Exception e){
                Log.e("exeption", e.getMessage());
                return  new String("Exception: " + e.getMessage());
            }


        }


   /* @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_inscription);
    }*/
    }


}
