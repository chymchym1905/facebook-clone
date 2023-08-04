/*eslint-disable*/
// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
const { logger, firestore } = require("firebase-functions");
// const { onRequest } = require("firebase-functions/v2/https");
// const { onDocumentCreated } = require("firebase-functions/v2/firestore");

// The Firebase Admin SDK to access Firestore.
const { initializeApp } = require("firebase-admin/app");
// const { getFirestore } = require("firebase-admin/firestore");

initializeApp();

exports.watchCommentCount = firestore
  .document("posts/{postid}/comments/{commentid}")
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();
    const parentID = data.parentID;

    if (parentID) {
      try {
        // Get the parent comment's reference
        const parentCommentRef = firestore
          .collection("posts")
          .doc(context.params.postid)
          .collection("comment")
          .doc(parentID);

        // Update the parent comment's childcommentcount field
        await parentCommentRef.update({
          childcommentcount: firestore.FieldValue.increment(1),
        });

        logger.log("Updated childcommentcount for parent comment:", parentID);
      } catch (error) {
        logger.error("Error updating parent comment:", error);
      }
    }
  });
