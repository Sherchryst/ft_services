<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', 'toor' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

define('FS_METHOD', 'direct');

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '@}!pQd{,);g<iF*T5ecn+oL8]vvyar6B@|+{#+5gF&1E:{Sqwb_1661Z3JeaYB|E');
define('SECURE_AUTH_KEY',  'tOM_sdw_;LIh-A|]S%lXb;K%fITD<~YPMke[6-T./-Ei6ZB##8T4R=n}+oQbirTK');
define('LOGGED_IN_KEY',    'L%!H}eFv-k5Wy-d0!c7jN4PX4k..}8>eltw)Yl_O]ejz@F%}%4CrV|fIj $}x:F&');
define('NONCE_KEY',        'WX}DR)VKc4/$/f;8z][OXb%UK*R?2TE6|?|k+6Par0q%:y:/q-aU9KbE(_A@ r4z');
define('AUTH_SALT',        'hsd{mzy~-gvLz^iwTix<?TxYs(i*.,!1ou%%BR!tK-O9_$~q/H@hV%s3GiH E*+G');
define('SECURE_AUTH_SALT', '{8r#DoGO[[4&It2[.$?2./EXNJ<e$Ce=]Z}-L+Nme,FjgF>{4i)Uv];D.=5Me;GK');
define('LOGGED_IN_SALT',   'z~Q2-=u9^*hVzO/g|+b)r~m%Zsk.g4#Fn0R9~2 Th~ l|5-}-XeWC#`Qt<Way;W`');
define('NONCE_SALT',       '4kSG]6+{/iBGQ#^}~o3&Ob8}->@,oavC3bY#u|`tx>aTV?E=dj,!jY4L^kL%E)*7');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) )
	define( 'ABSPATH', __DIR__ . '/var/www/wordpress' );

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';