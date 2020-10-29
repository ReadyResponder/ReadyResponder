## Issues found when installing on OSX 10.15, *Catalina*.

#### Wrong version of the bcrypt-gem.

  An error occurred while installing bcrypt-ruby (3.0.0).

  `Building native extensions.  This could take a   while...
  ERROR:  Error installing bcrypt-ruby:
         ERROR: Failed to build gem native extension.
  gem 'bcrypt-ruby', '~> 3.0.0'`

  The 3.0.0 version of this bcrypt-ruby gem is depending on 32-bit application support. Catalina has removed support for 32-bit.

###### Install the a later version of the bcrypt-gem,  3.1.0:
  Update the Gemfile and run `bundle install`
    `gem 'bcrypt-ruby', '~> 3.1.0'`

#### Installing the Thin HTTP server.
  Downgrade the version of V8, javascript engine, that the Thin gem depends on.

  `Error:
  In file included from ../src/allocation.cc:33:
  ../src/utils.h:33:10: fatal error: 'climits' file not found
  #include <climits> -->
            ^~~~~~~~~
  1 error generated.`

##### The workaround:
  https://gist.github.com/fernandoaleman/868b64cd60ab2d51ab24e7bf384da1ca


  `$ brew install v8@3.15**`
  `$ bundle config build.libv8 --with-system-v8`
  `$ bundle config build.therubyracer --with-v8-dir=$(brew --prefix v8@3.15)`

#### Error installing the rmagick gem.

##### Install verion 6 of imagemagick
  https://stackoverflow.com/questions/45669134/cant-install-rmagick-2-15-4-cant-find-magickwand-h

  `$ brew install imagemagick@6`
  `$ brew link imagemagick@6 --force`
  `$ gem install rmagick`

