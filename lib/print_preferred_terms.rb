##
 # Prints the preferred terms hierarchy to stdout
 # _____________________________________________________________________________
 #
 # Created by brightSPARK Labs
 # www.brightsparklabs.com
 ##

require File.expand_path('../zamarra/reader', __FILE__)
require File.expand_path('../zamarra/writer', __FILE__)

include Zamarra

document = Reader.read_zthes_xml ARGV[0]
Writer.write_preferred_terms document
