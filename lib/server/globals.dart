import 'package:clean_services_app/server/databases/cached_helper.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//import 'package:flutter/material.dart';
final HttpLink link = HttpLink('https://linnstad.mimusoft.com/graphql');

/*
 *
 * make qury or mutation ----> return widget
 * make  qury or mutation ---> return future
 *
 */
String mutationRegister = """
  mutation register(\$name:String!,\$email:String!,\$password:String!,\$password_confirmation:String!){
  register(
    input: {name:\$name,email:\$email,password:\$password
      ,password_confirmation:\$password_confirmation}){
    status
    tokens{
      user{
        name
        email
        created_at
      }
    }
  }
}
  
  """;

String mutationLogin = """
 mutation login(\$username:String!,\$password:String!){
  login(
    input: {username:\$username,password:\$password}){
    access_token
  }
}   
  
  """;

String getServicesQuery = """
{
  services{
      id
      title
      description
      image_url
      regulations{
        id
        title
        price_per_hour
        price_per_hour_without_RUT
        is_most_popular
	    	availableDatesAsArray
				availableDates{
          id
          date
        }        
      }
  }
}
""";
String durationQuery = """
 query (\$service_id:ID!, \$regulation_id:ID!){
   durationsQueries(
     input : {service_id : \$service_id , regulation_id : \$regulation_id}){
     id
     from
     to
     minimum_hours
   }
 }
""";

String enquiryCategoriesQuery = """
query (\$first:Int!){
 enquiryCategories( first : \$first  ){
    	data {
        id
        name
      }
}}
""";

String availableDatesQuery = """
query (\$regulation_id:Int!){
 enquiryCategories( regulation_id : \$regulation_id  ){
     id
     date
}}
""";

String enquiryCategoryQuery = """
query (\$id:ID!,\$first:Int!)
{ enquiryCategory(id : \$id)
  {
    enquiries (first : \$first){
      data {
        id
        question
        answer
      }
    
    }
  } 
}
""";

String createFeedbackMutation = """
mutation createFeedback(\$content: String!){
  createFeedback( input : {  content : \$content} ){
    id
    content
    is_replayed
  }
}
""";

String feedbacksQuery = """
{
  me {
    feedbacks (first : 50 ){
      data {
        id
        content
        is_replayed
        replay
      }
    }
  }  
}
""";
String signInWithGoogleMutation = """

mutation accessWithGoogle(\$email:String! , \$name: String!)
{
  accessWithGoogle(input:{
    email: \$email, name: \$name
  }){
    access_token
    user{
      name
      email
    }
  } 
}
""";

String createOrderMutation = """
  mutation createOrder(
    \$service_id:ID! , \$regulation_id:ID! ,
    \$time_to_serve:Float! , \$date_of_serve:Int! ,
    \$apartment_size:Float! , \$is_without_RUT:Boolean! ,
    \$payment_way:PaymentWay! ,  \$street_info:String! , 
    \$postcode:String! , \$first_name:String! ,
    \$last_name:String! , \$email:String! , 
    \$phone:String! , \$PID:String! , \$pets:[petInput!]
    
  ){
  createOrder(input:{
      service_id:\$service_id , regulation_id:\$regulation_id ,
      time_to_serve:\$time_to_serve , date_of_serve:\$date_of_serve ,
      apartment_size:\$apartment_size , is_without_RUT:\$is_without_RUT , 
       payment_way:\$payment_way , location: {street_info:\$street_info , postcode:\$postcode},
      buyer: {first_name:\$first_name , last_name:\$last_name , email:\$email , phone:\$phone , PID:\$PID},
      pets: \$pets
  }){
      url
      price
      price_after_discount
  }
}
""";

String giftQuery = """

{
me{
  allGifts{
    id
    name
    discount
    gift_status{
      status_code
      status
    }
    
  }
}
}
""";
String socialQuery = """

{
  socialInfos{
    name
    value
  }
}
""";

String ordersQuery = """
{
  me{
    orders{
      id
      apartment_size
      time_to_serve
	    date_of_serve
      created_at
      service{
        id
        title
        description
      }
      regulation{
        title
        id
        is_most_popular
        price_per_hour
        price_per_hour_without_RUT
      }
      location{
        postcode
        street_info
      }
      buyer{
        email
        PID
        phone
        first_name
        last_name
      }
      pets{
        id
        type
        number
      }
    payment{
      price
      status_code
      status
      price_after_discount
    }
      
    }
  }
}
    """;

final AuthLink authLink =
    AuthLink(getToken: () => "Bearer ${CachedHelper.getValue("access_token")}");

GraphQLClient globalClient = GraphQLClient(
  //cache: GraphQLCache(store: HiveStore()),
  cache: GraphQLCache(store: HiveStore()),
  link: authLink.concat(link),
);

/*
final AuthLink authLink = AuthLink(

    getToken: () async =>
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NTBlM2NiOS01OGFlLTQyZmQtYjI3OS1iODA4NjRiNDg3MTMiLCJqdGkiOiIzY2NmYmQ2YzkzZjk2NGM3NzMwNjJlMTBlYmQ4MWM0OWFlZGFlYjQxMzQ1Y2QzNzUzODUxZGVmMDdlMzRmZDMzYjlhOGJkZDY2MmFkNmY3MyIsImlhdCI6MTYzODk2MDU0NS42MTc4MTY5MjUwNDg4MjgxMjUsIm5iZiI6MTYzODk2MDU0NS42MTc4MjI4ODU1MTMzMDU2NjQwNjI1LCJleHAiOjE2NzA0OTY1NDUuNTkzNDQ3OTIzNjYwMjc4MzIwMzEyNSwic3ViIjoiMTYiLCJzY29wZXMiOltdfQ.pvtvdcq3ic6p0jbpC0vvYYlTOQq_Zryl7zwJ0u85bceX0TWTno8eJwhWN7H10ngvLaxyqSGMBiVn7Bpjs_VqaPpp8Xf3YLiBeF9se2AgBIjK-nNpJ5BPDBT142ncKJDn-8NyUcKtlXsN206xi4_oL93hP93Wbz_4qz7b5PKn9UovvR1DYECi2tpTymglBLB2VRZzt-IfzryNJ-8h5VW6byjyYdh9GNxIMl0WQZBXVZ8nSnF_rCGfb7VV1jvU_ufoWutJ8jMhDAhctJZQ_a4K5c0ScOKl7VtsMSBfg_wDv2VLcgx-CpcilzHWLdC0fNmiBNaSi7hFEQojzzvTkUiqsl5d4f-Cp_XiNxClSKzLoWl1yZchhsakJGnOetOHU2icB0gZYPlLnJdPcvA9b5xXfvSAqzILUfjxtD4jz0hHo4DENaT8he7kiKlC6gQqRNhWh_1pcrcqT4-gj2mRrAHMAe1rUOGPhCSaOakoNfvZE-gloq8T-eCcEDzBNpliDxPVi31-R1SWw32VdX8z4Q6tG4zCXvrxJgvaB0ycgUMT0zdHtyKqHGoy7At9xzkLk4h7f91lThQrvr1y_ZrVSNcjiazZWGWwmRnMX3f-yrCeah70ENlJvtbDboCUgQu6ijt7Mz_hWGGQmuLKNF-r6sBRFN_gKXQGQibHPGqeUPQtND8");

*/
/*
log(
"${message.exception!.graphqlErrors.first.extensions!["validation"]["input.email"]}")
*/
