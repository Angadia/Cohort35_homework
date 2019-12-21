
exports.up = function(knex) {
  return knex.schema.createTable("cohorts", (t) => {
    t.bigIncrements("id");
    t.string("name");
    t.string("logo_url");
    t.text("members");
    t.timestamps(true, true);
  });
};

exports.down = function(knex) {
  return knex.schema.dropTable("cohorts");
};
