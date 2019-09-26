# Drop

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Questions and Answers
* What was the hardest part of the implementation?
    * Hardest part for me was trying to figure out what to do with multiple types of users. Spent a really long time thinking about using a many to many table between users and roles, only to end up using my original, simplier idea. Also spent a lot of time trying to figure out how to refresh session information in case a pharmacist or courier updates their information. Spent an embarrassing amount of time trying to add an attribute to Coherence registration, only to find how to do it in a config file. 
* What would be your next couple of tasks if you had more time?
    * If I had more time I would find a more elegant way of handling different types of users, and uncomment out the stuff I put in for Canary/Canada authorization management. I've used it in another project before and really like it. 
* How could we change the project to be more interesting?
    * Add something with Google maps or something to simulate the live delivery of an order.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
