# README

## Update Decidim

To update the Decidim installation on this project, first we update Gemfile dependencies, then we call the Decidim upgrade script and then we apply migrations (if any)

- `bundle update decidim decidim-dev`
- `bin/rails decidim:upgrade`
- `bin/rails db:migrate`

## Development

**Development environment installation**

- Install development environment (Ruby 2.4+, PostgreSQL 9.4+). Check the following guide for instructions on different OS: https://gorails.com/setup/
- Clone the repository: `git clone git@github.com:diputacioBCN/decidim-diba.git`
- `cd decidim-diba`
- Install dependencies: `bundle install`
- Setup database: `bin/rails db:setup`
- Add fake data to the database: `bin/rails db:seed`
- Launch development server: `bin/rails server`

More information can be found in the Decidim github repository: https://github.com/decidim/decidim

**Running tests**

Run: `rspec`


**Testing emails in development**

Decidim is using the [letter_opener_web](https://github.com/fgrehm/letter_opener_web) gem. To see all emails sent in the development environment you can do it by visiting the https://localhost:3000/letter_opener URL.
