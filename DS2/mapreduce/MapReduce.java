import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.IOException;
import java.util.Arrays;
import java.util.StringTokenizer;

/* MapReduce calculates the percentage of times the artist writes and produces his/her own songs. */
public class MapReduce {

    /* Under key "artist", MyMapper sends 2 boolean values, 
    e.g. sends "1:1" when both "producer" and "lyrics" contain the name of the artist. */
    public static class MyMapper extends Mapper<Object, Text, Text, Text> {

        @Override
        public void map(Object key, Text value, Context context
        ) throws IOException, InterruptedException {

            // Tokenizer for whole rows
            StringTokenizer i = new StringTokenizer(value.toString(), ";");
            String artist = i.nextToken();

            // Initiating boolean values
            boolean isProducer = false; 
            boolean isWriter = false;
            while (i.hasMoreTokens()) {
                String token = i.nextToken();
                // Setting the denominator for producer and splitting up data
                if (token.equals("producers")) {
                    String[] producers = i.nextToken().split("/");
                    // Check if array 'producers' contains artist's name
                    isProducer = Arrays.asList(producers).contains(artist);
                }
                // Setting the denominator for lyrics and splitting up data
                if (token.equals("lyrics")) {
                    String[] writers = i.nextToken().split("/");
                    // Check if array 'writers' contains artist's name
                    isWriter = Arrays.asList(writers).contains(artist);
                }
            }
            // Creating a string of booleans for artist's "statistics"
            String stats = "" + (isProducer ? 1 : 0) + ":" + (isWriter ? 1 : 0);
            context.write(new Text(artist), new Text(stats));
        }
    }
        /*  Takes information sent from MyMapper and aggregates data. Makes calculations. */
        public static class MyReducer extends Reducer<Text, Text, Text, Text> {

            @Override
            public void reduce(Text key, Iterable<Text> values, Context context
            ) throws IOException, InterruptedException {

                int producerCount = 0; // how many times artist produced
                int writerCount = 0; // how many times artist wrote texts
                int count = 0; // total amount of songs

                // Go through values and count all of them
                for (Text value : values) {
                    String value2 = value.toString();
                    producerCount += value2.charAt(0) - '0';
                    writerCount += value2.charAt(2) - '0';
                    count++;
                }

                // Producing the final string
                StringBuilder sb = new StringBuilder();
                sb.append(": produced ").append((producerCount/(float)count)*100).
                        append(" % of times, wrote lyrics ").
                        append((writerCount/(float)count)*100).append(" % of times.");

                context.write(key, new Text(sb.toString()));
            }
        }

        public static void main(String[] args) throws Exception {

            Configuration conf = new Configuration();

            Job job = Job.getInstance(conf, "Artist's statistics on song-writing.");

            job.setJarByClass(MapReduce.class);
            job.setMapperClass(MyMapper.class);
            job.setReducerClass(MyReducer.class);
            job.setOutputKeyClass(Text.class);
            job.setOutputValueClass(Text.class);

            FileInputFormat.addInputPath(job, new Path(args[0]));
            FileOutputFormat.setOutputPath(job, new Path(args[1]));

            System.exit(job.waitForCompletion(true) ? 0 : 1);

        }
}
