# frozen_string_literal: true

FriendlyId.defaults do |config|
  # ## Reserved Words
  #
  # Some words could conflict with Rails's routes when used as slugs, or are
  # undesirable to allow as slugs. Edit this list as needed for your app.
  config.use :reserved

  config.reserved_words = %w[new edit index session login logout users admin
                             stylesheets assets javascripts images]

  # This adds an option to treat reserved words as conflicts rather than exceptions.
  # When there is no good candidate, a UUID will be appended, matching the existing
  # conflict behavior.

  # config.treat_reserved_as_conflict = true

  #  ## Friendly Finders
  #
  # Uncomment this to use friendly finders in all models. By default, if
  # you wish to find a record by its friendly id, you must do:
  #
  #    MyModel.friendly.find('foo')
  #
  # If you uncomment this, you can do:
  #
  #    MyModel.find('foo')
  #
  # This is significantly more convenient but may not be appropriate for
  # all applications, so you must explicity opt-in to this behavior. You can
  # always also configure it on a per-model basis if you prefer.
  #
  # Something else to consider is that using the :finders addon boosts
  # performance because it will avoid Rails-internal code that makes runtime
  # calls to `Module.extend`.
  #
  config.use :finders
  #
  # ## Slugs
  #
  # Most applications will use the :slugged module everywhere. If you wish
  # to do so, uncomment the following line.
  #
  # config.use :slugged
  #
  # By default, FriendlyId's :slugged addon expects the slug column to be named
  # 'slug', but you can change it if you wish.
  #
  # config.slug_column = 'slug'
  #
  # By default, slug has no size limit, but you can change it if you wish.
  #
  # config.slug_limit = 255
  #
  # When FriendlyId can not generate a unique ID from your base method, it appends
  # a UUID, separated by a single dash. You can configure the character used as the
  # separator. If you're upgrading from FriendlyId 4, you may wish to replace this
  # with two dashes.
  #
  # config.sequence_separator = '-'
end
